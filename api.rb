#!/usr/bin/ruby
require 'chilkat'
require 'ostruct'
require 'optparse'

ftp = Chilkat::CkFtp2.new()
#filename = ARGV

ftp.put_Hostname("REDACTED")
#ftp.put_Port(1946)
ftp.put_Username("REDACTED")
ftp.put_Password("REDACTED")

ftp.put_BandwidthThrottleUp(10000)

# Connect and login to the FTP server.
success = ftp.Connect()
if (success != true)
    print ftp.lastErrorText() + "\n";
    exit
end

#change directory 
ftp.ChangeRemoteDir("~/Desktop/Trevor")
if (success != true)
    print ftp.lastErrorText() + "\n";
    exit
end


# displaying options for the tool
OptionParser.new do |opt|
    opt.on('--file <path_to_the_file>','file to upload') { |o| 
    filename = o 

success = ftp.PutFile(filename , File.basename(filename))
    if (success != true)
        print ftp.lastErrorText() + "\n";
    exit
	end

	

success = ftp.PutFile(filename , File.basename(filename))
if (success != true)
   print ftp.lastErrorText() + "\n";
   exit
end

success = ftp.Disconnect()

print "File Uploaded!" + "\n";


    }

opt.on('--list','lists the contents of the ftp server') { |o| 
    # options[:last_name] = o 
# The ListPattern property is our directory listing filter.
# The default value is "*", which includes everything.
print ftp.listPattern() + "\n";

# To get file and sub-directory information, simply
# loop from 0 to ftp.GetDirCount() - 1

n = ftp.GetDirCount()
if (n < 0)
    print ftp.lastErrorText() + "\n";
    exit
end

if (n > 0)
    for i in 0 .. n - 1

        # Display the filename
        print "name of the file: " + ftp.getFilename(i) + "\n";

        # Display the file size (in bytes)
        print "size of the file in bytes: " + ftp.GetSize(i).to_s() + "\n";

        # Is this a sub-directory?
        if (ftp.GetIsDirectory(i) == true)
            print ".. this is a sub-directory" + "\n";
        end

        print "--" + "\n";
    end
end
    }
end.parse!





