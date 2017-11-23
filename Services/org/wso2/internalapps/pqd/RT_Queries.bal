package org.wso2.internalapps.pqd;


const string RT_PROJECT_ID_CHECK = "SELECT ROW_UPDATE_EPOCH_TIME_STAMP epochTime FROM RM_PROJECT WHERE PROJECT_ID=?";
const string RT_PROJECT_INSERT = "INSERT INTO RM_PROJECT (PROJECT_ID,PROJECT_NAME,PROJECT_IDENTIFIER,PROJECT_DESCRIPTION,PROJECT_STATUS,PROJECT_IS_PUBLIC,PROJECT_CREATED_ON,PROJECT_UPDATE_ON,ROW_UPDATE_EPOCH_TIME_STAMP) VALUES (?,?,?,?,?,?,?,?,?)";
const string RT_PROJECT_UPDATE = "UPDATE RM_PROJECT SET PROJECT_NAME=?, PROJECT_IDENTIFIER=?, PROJECT_DESCRIPTION=?, PROJECT_STATUS=?, PROJECT_IS_PUBLIC=?, PROJECT_CREATED_ON=?, PROJECT_UPDATE_ON=?, ROW_UPDATE_EPOCH_TIME_STAMP=? WHERE PROJECT_ID=?";

const string RT_USER_ID_CHECK = "SELECT COUNT(*) rowCount FROM RM_USER WHERE USER_ID=?";
const string RT_USER_INSERT = "INSERT INTO RM_USER (USER_ID,USER_FIRST_NAME,USER_LAST_NAME,USER_EMAIL,USER_CREATED_ON,USER_LAST_LOGIN_ON) VALUES (?,?,?,?,?,?)";

const string RT_VERSION_HELP = "SELECT PROJECT_ID ID FROM RM_PROJECT";
const string RT_VERSION_ID_CHECK = "SELECT ROW_UPDATE_EPOCH_TIME_STAMP epochTime from RM_VERSION WHERE VERSION_ID=? and PARENT_PROJECT_ID=?";
const string RT_VERSION_INSERT = "INSERT INTO RM_VERSION (VERSION_ID,PROJECT_ID,PARENT_PROJECT_ID,VERSION_NAME,VERSION_DESCRIPTION,VERSION_STATUS,VERSION_DUE_DATE,VERSION_SHARING,VERSION_MARKETING_DESCRIPTION,VERSION_CARBON_VERSION,VERSION_DEPENDS_ON,VERSION_VISION_DOCUMENT,VERSION_START_DATE,VERSION_RELEASE_MANAGER,VERSION_WARRANTY_MANAGER,VERSION_CREATED_ON,VERSION_UPDATED_ON,ROW_UPDATE_EPOCH_TIME_STAMP) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
const string RT_VERSION_UPDATE = "Update RM_VERSION SET VERSION_NAME=?,VERSION_DESCRIPTION=?, VERSION_STATUS=?,VERSION_DUE_DATE=?, VERSION_SHARING=?, VERSION_MARKETING_DESCRIPTION=?, VERSION_CARBON_VERSION=?,  VERSION_DEPENDS_ON=?,VERSION_VISION_DOCUMENT=?, VERSION_START_DATE=?, VERSION_RELEASE_MANAGER=?, VERSION_WARRANTY_MANAGER=?, VERSION_CREATED_ON=?, VERSION_UPDATED_ON=?, ROW_UPDATE_EPOCH_TIME_STAMP=? WHERE VERSION_ID=? and PARENT_PROJECT_ID=?";

const string RT_ISSUE_ID_CHECK = "SELECT ISSUE_UPDATED_ON,ROW_UPDATE_EPOCH_TIME_STAMP epochTime FROM RM_ISSUE WHERE ISSUE_ID=?";
const string RT_ISSUE_INSERT = "INSERT INTO RM_ISSUE (ISSUE_ID,ISSUE_PROJECT_ID,ISSUE_PROJECT_NAME,ISSUE_TRACKER_ID,ISSUE_TRACKER_NAME,ISSUE_FIXED_VERSION_ID,ISSUE_FIXED_VERSION_NAME,ISSUE_TRACKER_SUBJECT,ISSUE_CREATED_ON,ISSUE_UPDATED_ON, ROW_UPDATE_EPOCH_TIME_STAMP) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
const string RT_ISSUE_UPDATE = "UPDATE RM_ISSUE SET ISSUE_PROJECT_ID=?, ISSUE_PROJECT_NAME=?, ISSUE_TRACKER_ID=?, ISSUE_TRACKER_NAME=?, ISSUE_FIXED_VERSION_ID=?, ISSUE_FIXED_VERSION_NAME=?, ISSUE_TRACKER_SUBJECT=?, ISSUE_CREATED_ON=?, ISSUE_UPDATED_ON=?, ROW_UPDATE_EPOCH_TIME_STAMP=? WHERE ISSUE_ID=?";

const string GET_ALL_RELEASES_Q_1 = "SELECT VERSION_DUE_DATE AS releaseDate FROM RM_VERSION WHERE VERSION_DUE_DATE !=? AND VERSION_DUE_DATE  GROUP BY VERSION_DUE_DATE ASC;";
const string GET_ALL_RELEASES_Q_2 = "SELECT c.GITHUB_REPO_NAME,a.VERSION_ID,c.PROJECT_ID,c.PROJECT_NAME,c.PRODUCT_AREA,a.VERSION_NAME AS releaseProduct,d.USER_FIRST_NAME AS releaseManagerF,d.USER_LAST_NAME AS releaseManagerL,e.USER_FIRST_NAME AS warrantyManagerF,e.USER_LAST_NAME AS warrantyManagerL,a.VERSION_DUE_DATE AS start FROM RM_VERSION AS a LEFT JOIN  RM_MAPPING AS c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER AS d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER AS e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_DUE_DATE=?;";
const string GET_ALL_RELEASES_Q_3 = "SELECT COUNT(*) AS featureCount FROM RM_VERSION a LEFT JOIN RM_ISSUE b  ON  a.VERSION_ID = b.ISSUE_FIXED_VERSION_ID LEFT JOIN RM_MAPPING c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_ID=? AND b.ISSUE_TRACKER_ID=?;";
const string GET_ALL_RELEASES_Q_4 = "SELECT COUNT(*) AS storyCount FROM RM_VERSION a LEFT JOIN RM_ISSUE b  ON  a.VERSION_ID = b.ISSUE_FIXED_VERSION_ID LEFT JOIN RM_MAPPING c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_ID=? AND b.ISSUE_TRACKER_ID=?;";

const string GET_RELEASES_BY_PRODUCT_Q_1 = "SELECT a.VERSION_DUE_DATE AS releaseDate FROM RM_VERSION AS a LEFT JOIN  RM_MAPPING AS c ON a.PARENT_PROJECT_ID=c.PROJECT_ID WHERE a.VERSION_DUE_DATE !=? AND c.PRODUCT_AREA=? AND VERSION_DUE_DATE  GROUP BY VERSION_DUE_DATE ASC;";
const string GET_RELEASES_BY_PRODUCT_Q_2 = "SELECT c.GITHUB_REPO_NAME,a.VERSION_ID,c.PROJECT_ID,c.PROJECT_NAME,c.PRODUCT_AREA,a.VERSION_NAME AS releaseProduct,d.USER_FIRST_NAME AS releaseManagerF,d.USER_LAST_NAME AS releaseManagerL,e.USER_FIRST_NAME AS warrantyManagerF,e.USER_LAST_NAME AS warrantyManagerL,a.VERSION_DUE_DATE AS start from RM_VERSION AS a LEFT JOIN  RM_MAPPING AS c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER AS d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER AS e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_DUE_DATE=? AND c.PRODUCT_AREA=?;";
const string GET_RELEASES_BY_PRODUCT_Q_3 = "SELECT COUNT(*) AS featureCount FROM RM_VERSION a LEFT JOIN RM_ISSUE b  ON  a.VERSION_ID = b.ISSUE_FIXED_VERSION_ID LEFT JOIN RM_MAPPING c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_ID=? AND b.ISSUE_TRACKER_ID=? AND c.PRODUCT_AREA=?;";
const string GET_RELEASES_BY_PRODUCT_Q_4 = "SELECT COUNT(*) AS storyCount FROM RM_VERSION a LEFT JOIN RM_ISSUE b  ON  a.VERSION_ID = b.ISSUE_FIXED_VERSION_ID LEFT JOIN RM_MAPPING c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_ID=? AND b.ISSUE_TRACKER_ID=? AND c.PRODUCT_AREA=?;";

const string GET_MANAGERS_Q_1 = "SELECT a.VERSION_ID,c.PROJECT_ID,c.PROJECT_NAME,c.PRODUCT_AREA,a.VERSION_NAME AS releaseProduct,d.USER_FIRST_NAME AS releaseManagerF,d.USER_LAST_NAME AS releaseManagerL,e.USER_FIRST_NAME AS warrantyManagerF,e.USER_LAST_NAME AS warrantyManagerL,a.VERSION_DUE_DATE AS start FROM RM_VERSION AS a LEFT JOIN RM_MAPPING AS c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER AS d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER AS e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_DUE_DATE BETWEEN ? AND ? ORDER BY a.VERSION_DUE_DATE ASC;";
const string GET_MANAGERS_Q_2 = "SELECT a.VERSION_ID,c.PROJECT_ID,c.PROJECT_NAME,c.PRODUCT_AREA,a.VERSION_NAME AS releaseProduct,d.USER_FIRST_NAME AS releaseManagerF,d.USER_LAST_NAME AS releaseManagerL,e.USER_FIRST_NAME AS warrantyManagerF,e.USER_LAST_NAME AS warrantyManagerL,a.VERSION_DUE_DATE AS start from RM_VERSION as a LEFT JOIN RM_MAPPING AS c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER AS d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER AS e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_DUE_DATE BETWEEN ? AND ? AND c.PRODUCT_AREA =? ORDER BY a.VERSION_DUE_DATE ASC;";
const string GET_MANAGERS_Q_3 = "SELECT COUNT(*) AS featureCount FROM RM_VERSION a LEFT JOIN RM_ISSUE b  ON  a.VERSION_ID = b.ISSUE_FIXED_VERSION_ID LEFT JOIN RM_MAPPING c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_ID=? AND b.ISSUE_TRACKER_ID=?;";
const string GET_MANAGERS_Q_4 = "SELECT COUNT(*) AS storyCount FROM RM_VERSION a LEFT JOIN RM_ISSUE b  ON  a.VERSION_ID = b.ISSUE_FIXED_VERSION_ID LEFT JOIN RM_MAPPING c ON a.PARENT_PROJECT_ID=c.PROJECT_ID LEFT JOIN RM_USER d ON a.VERSION_RELEASE_MANAGER=d.USER_ID LEFT JOIN RM_USER e ON a.VERSION_WARRANTY_MANAGER=e.USER_ID WHERE a.VERSION_ID=? AND b.ISSUE_TRACKER_ID=?;";

const string GET_TRACKER_SUBJECTS_Q_1 = "SELECT ISSUE_TRACKER_SUBJECT AS subject ,ISSUE_ID AS issueId FROM RM_ISSUE WHERE ISSUE_TRACKER_ID=? AND ISSUE_FIXED_VERSION_ID=?;";

const string GET_REPO_AND_VERSION_Q_1= "SELECT GITHUB_REPO_NAME AS repoName FROM RM_PROJECT_TO_GITREPO_MAPPING WHERE PROJECT_ID=?";
const string GET_REPO_AND_VERSION_Q_2= "SELECT VERSION_NAME AS versionName FROM RM_VERSION WHERE VERSION_ID=?";
