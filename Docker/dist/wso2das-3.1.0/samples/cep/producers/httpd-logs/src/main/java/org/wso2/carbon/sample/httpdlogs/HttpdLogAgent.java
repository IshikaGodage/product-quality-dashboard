/*
*  Copyright (c) 2005-2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
*  WSO2 Inc. licenses this file to you under the Apache License,
*  Version 2.0 (the "License"); you may not use this file except
*  in compliance with the License.
*  You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
*/
package org.wso2.carbon.sample.httpdlogs;

import org.wso2.carbon.databridge.agent.AgentHolder;
import org.wso2.carbon.databridge.agent.DataPublisher;
import org.wso2.carbon.databridge.agent.exception.DataEndpointAgentConfigurationException;
import org.wso2.carbon.databridge.agent.exception.DataEndpointAuthenticationException;
import org.wso2.carbon.databridge.agent.exception.DataEndpointConfigurationException;
import org.wso2.carbon.databridge.agent.exception.DataEndpointException;
import org.wso2.carbon.databridge.commons.Event;
import org.wso2.carbon.databridge.commons.exception.*;
import org.wso2.carbon.databridge.commons.utils.DataBridgeCommonsUtils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.MalformedURLException;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Scanner;

public class HttpdLogAgent {
    private static final String HTTPD_LOG_STREAM = "org.wso2.sample.httpd.logs";
    private static final String VERSION = "1.0.0";
    private static final int MAX_LOGS = 1000;
    private static final String SAMPLE_LOG_PATH = "resources/access.log";

    public static void main(String[] args)
            throws SocketException, MalformedURLException, AuthenticationException, TransportException, StreamDefinitionException, MalformedStreamDefinitionException, DifferentStreamDefinitionAlreadyDefinedException,
            FileNotFoundException, UnknownHostException, DataEndpointAuthenticationException, DataEndpointAgentConfigurationException, DataEndpointException, DataEndpointConfigurationException {
        System.out.println("Starting HttpLog Agent");

        DataPublisherUtil.setTrustStoreParams();

        AgentHolder.setConfigPath(DataPublisherUtil.getAgentConfigPath());

        String host = args[0];
        String port = args[1];
        String username = args[2];
        String password = args[3];

        //create data publisher

        DataPublisher dataPublisher = new DataPublisher("tcp://" + host + ":" + port, username, password);

        String streamId = DataBridgeCommonsUtils.generateStreamId(HTTPD_LOG_STREAM,VERSION);

//        try {
//            streamId = dataPublisher.findStream(HTTPD_LOG_STREAM, VERSION);
//            System.out.println("Stream already defined");
//
//        } catch (NoStreamDefinitionExistException e) {
//            //Define event stream
//            streamId = dataPublisher.defineStream("{" +
//                                                  "  'name':'" + HTTPD_LOG_STREAM + "'," +
//                                                  "  'version':'" + VERSION + "'," +
//                                                  "  'nickName': 'Httpd_Log_Stream'," +
//                                                  "  'description': 'Sample of Httpd logs'," +
//                                                  "  'metaData':[" +
//                                                  "          {'name':'clientType','type':'STRING'}" +
//                                                  "  ]," +
//                                                  "  'payloadData':[" +
//                                                  "          {'name':'log','type':'STRING'}" +
//                                                  "  ]" +
//                                                  "}");
//
//        }
        if (null != streamId && !streamId.isEmpty()) {
            publishLogEvents(dataPublisher, streamId);
        }
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
        }

        dataPublisher.shutdownWithAgent();
    }

    private static void publishLogEvents(DataPublisher dataPublisher, String streamId) throws FileNotFoundException {
        Scanner scanner = new Scanner(new FileInputStream(SAMPLE_LOG_PATH));
        try {
            int i = 1;
            while (scanner.hasNextLine()) {
                System.out.println("Publish log event : " + i);
                String aLog = scanner.nextLine();
                Event event = new Event(streamId, System.currentTimeMillis(), new Object[]{"external"}, null,
                                        new Object[]{aLog});
                dataPublisher.publish(event);
                i++;
            }
        } finally {
            scanner.close();
        }
    }


}
