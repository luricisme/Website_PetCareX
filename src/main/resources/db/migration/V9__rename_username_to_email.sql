EXEC sp_rename 'account.Username', 'Email', 'COLUMN';

ALTER TABLE Account
ALTER COLUMN Email VARCHAR(255);