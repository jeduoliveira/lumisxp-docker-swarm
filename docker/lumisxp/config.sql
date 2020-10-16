DELETE FROM lum_CfgEnvironmentConf;

INSERT INTO lum_CfgEnvironmentConf (id, type, fileSystemImplementation, javaMelodyEnabled, bigDataRepositoryType, esClusterName,esConnectionAddresses,esHttpConnectionAddresses, esBulkConcurrentRequests, useUserGroupsSessionCache) 
VALUES(  '000000000A00000000000A0000100000', 'DEVELOPMENT','lumis.portal.filesystem.impl.SingleCopyFileSystem', 1,'ELASTICSEARCH_TRANSPORT_CLIENT', 'ELASTICSEARCH_CLUSTER_NAME', 'ELASTICSEARCH_TRANSPORT_HOST', 'ELASTICSEARCH_HOST', 10,1);

UPDATE lum_Website set webRootPath='WEB_ROOT_PATH' where name ='default';

UPDATE lum_WebsiteBaseURL set path =null;
UPDATE lum_WebsiteBaseURL set port=80 where port = 8080;

update lum_ClusterConfig set durableMessageTimeToLive=0;

COMMIT;