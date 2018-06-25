class FileUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.Mid}"
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir
    
    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end

  

end