class FileList < ApplicationRecord
	mount_uploader :file, FileUploader
end
