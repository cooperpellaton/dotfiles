case RbConfig::CONFIG['host_os']
when /mac|darwin/ then require File.expand_path('../rgloader193.darwin.bundle', __FILE__)
when /mswin|win|mingw/ then require File.expand_path('../rgloader193.mswin.so', __FILE__)
when /linux\-gnu/ 
  if RbConfig::CONFIG['arch'] == 'x86_64-linux'
    require File.expand_path('../rgloader193.linux.x86_64.so', __FILE__)
  else
    require File.expand_path('../rgloader193.linux.so', __FILE__)
  end
end
