CREATE OR ALTER TRIGGER BBCT.T_SEAL_METRO_PAIR_HISTORY 
ON BBCT.T_SEAL_METRO_PAIR
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
	DECLARE @INSERTCOUNT int, @DELETEDCOUNT int, 
	@INSERTEDCOVERPAGENO varchar(13), @INSERTEDMETROID varchar(10), @INSERTEDREMARK varchar(5), 
	@INSERTEDDATEPAIRED varchar(10), @INSERTEDPAIREDBY varchar(10), @INSERTEDDATECALIBRATED varchar(10), 
	@DELETEDCOVERPAGENO varchar(13), @DELETEDMETROID varchar(10), @DELETEDREMARK varchar(5), 
	@DELETEDDATEPAIRED varchar(10), @DELETEDPAIREDBY varchar(10), @DELETEDDATECALIBRATED varchar(10)
	
	SET @INSERTCOUNT = (SELECT COUNT(*) FROM INSERTED);
	SET @DELETEDCOUNT = (SELECT COUNT(*) FROM DELETED);

	SET @INSERTEDCOVERPAGENO = (SELECT COVER_PAGE_NO FROM INSERTED);
	SET @INSERTEDMETROID = (SELECT CONVERT(varchar(10),METRO_ID)_NO FROM INSERTED);
	SET @INSERTEDREMARK = (SELECT ISNULL(REMARK, 'NULL') FROM INSERTED);
	SET @INSERTEDDATEPAIRED = (SELECT CONVERT(varchar(10), DATE_PAIRED, 6) FROM INSERTED);
	SET @INSERTEDPAIREDBY = (SELECT PAIRED_BY FROM INSERTED);
	SET @INSERTEDDATECALIBRATED = (SELECT CONVERT(varchar(10), DATE_CALIBRATED, 6) FROM INSERTED);
	SET @DELETEDCOVERPAGENO = (SELECT COVER_PAGE_NO FROM DELETED);
	SET @DELETEDMETROID = (SELECT CONVERT(varchar(10),METRO_ID)_NO FROM DELETED);
	SET @DELETEDREMARK = (SELECT ISNULL(REMARK, 'NULL') FROM DELETED);
	SET @DELETEDDATEPAIRED = (SELECT CONVERT(varchar(10), DATE_PAIRED, 6) FROM DELETED);
	SET @DELETEDPAIREDBY = (SELECT PAIRED_BY FROM DELETED);
	SET @DELETEDDATECALIBRATED = (SELECT CONVERT(varchar(10), DATE_CALIBRATED, 6) FROM DELETED);

	SET NOCOUNT ON;
	
		if (@INSERTCOUNT >0 AND @DELETEDCOUNT > 0)
			BEGIN
				PRINT 'Update';
				if (@INSERTEDCOVERPAGENO  != @DELETEDCOVERPAGENO)
				BEGIN
					INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'U', @DELETEDCOVERPAGENO, @INSERTEDCOVERPAGENO, 'Updated ' + ' cover seal from ' + @DELETEDCOVERPAGENO + ' to ' + @INSERTEDCOVERPAGENO, 'CF000000');
				END
				if (@INSERTEDMETROID != @DELETEDMETROID)
				BEGIN
					INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'U',  @DELETEDMETROID, @INSERTEDMETROID, 'Updated ' + @DELETEDCOVERPAGENO + ' and ' + @DELETEDMETROID + ' seal-METRO pair METRO id from ' + @DELETEDMETROID + ' to ' + @INSERTEDMETROID, 'CF000000');
				END
				if (@INSERTEDREMARK  != @DELETEDREMARK)
				BEGIN
					INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'U', @DELETEDREMARK, @INSERTEDREMARK, 'Updated ' + @INSERTEDCOVERPAGENO + ' and ' + @INSERTEDMETROID + ' seal-METRO pair remark from ' + @DELETEDREMARK + ' to ' + @INSERTEDREMARK, 'CF000000');
				END
				if (@INSERTEDDATEPAIRED != @DELETEDDATEPAIRED)
				BEGIN
					INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'U',@DELETEDDATEPAIRED, @INSERTEDDATEPAIRED, 'Updated ' + @INSERTEDCOVERPAGENO + ' and ' + @INSERTEDMETROID + ' seal-METRO pair date created from ' + @DELETEDDATEPAIRED + ' to ' + @INSERTEDDATEPAIRED, 'CF000000');
				END
				if (@INSERTEDPAIREDBY != @DELETEDPAIREDBY)
				BEGIN
					INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'U', @DELETEDPAIREDBY, @INSERTEDPAIREDBY, 'Updated ' + @INSERTEDCOVERPAGENO + ' and ' + @INSERTEDMETROID + ' seal-METRO pair date calibrated from ' + @DELETEDPAIREDBY + ' to ' + @INSERTEDPAIREDBY, 'CF000000');
				END
				if (@INSERTEDDATECALIBRATED != @DELETEDDATECALIBRATED)
				BEGIN
					INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'U', @DELETEDDATECALIBRATED , @INSERTEDDATECALIBRATED, 'Updated ' + @INSERTEDCOVERPAGENO + ' and ' + @INSERTEDMETROID + ' seal-METRO pair date calibrated from ' + @DELETEDDATECALIBRATED  + ' to ' + @INSERTEDDATECALIBRATED, 'CF000000');
				END
			END
		else 
			if (@INSERTCOUNT >0 AND @DELETEDCOUNT=0)
				BEGIN
					INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'I', null, @INSERTEDCOVERPAGENO + ', ' + @INSERTEDMETROID, 'Inserted ' + @INSERTEDCOVERPAGENO + ' and ' + @INSERTEDMETROID + ' seal-METRO pair', 'CF000000');		
				END
			else 
			if (@INSERTCOUNT=0 AND @DELETEDCOUNT > 0)
			BEGIN
				INSERT INTO BBCT.T_HISTORY (DATE_DONE, TABLE_NAME, ACTIVITY, DATA_FROM, DATA_TO, DESCRIPTION, USERNAME) VALUES (CURRENT_TIMESTAMP, 'T_SEAL_METRO_PAIR', 'D', @DELETEDCOVERPAGENO + ', ' + @DELETEDMETROID, null, 'Deleted ' + @DELETEDCOVERPAGENO  + ' and ' + @DELETEDMETROID  + ' seal-METRO pair', 'CF000000');
			END
END
