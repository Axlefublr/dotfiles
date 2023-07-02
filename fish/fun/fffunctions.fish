#!/usr/bin/env fish

function cut
	ffmpeg.exe -i $argv[1] -ss $argv[3] -to $argv[4] -c:a copy $argv[2]
end
funcsave cut > /dev/null

function cutfrom
	ffmpeg.exe -i $argv[1] -ss $argv[3] -c:a copy $argv[2]
end
funcsave cutfrom > /dev/null

function cutto
	ffmpeg.exe -i $argv[1] -ss 00:00 -to $argv[3] -c:a copy $argv[2]
end
funcsave cutto > /dev/null

function cutout
	ffmpeg.exe -i $argv[1] -to $argv[3] -c:a copy input1.mp4
	ffmpeg.exe -i $argv[1] -ss $argv[4] -c:a copy input2.mp4
	combine input1.mp4 input2.mp4 $argv[2]
	rm input1.mp4 input2.mp4
end
funcsave cutout > /dev/null

function compress
	ffmpeg.exe -i $argv[1] -c:v libx264 -crf 28 -preset veryslow -c:a aac -b:a 64k -movflags +faststart $argv[2]
end
funcsave compress > /dev/null

function combine
	ffmpeg.exe -i $argv[1] -c copy -bsf:v h264_mp4toannexb -f mpegts input1.ts
	ffmpeg.exe -i $argv[2] -c copy -bsf:v h264_mp4toannexb -f mpegts input2.ts
	echo "file 'input1.ts'
	file 'input2.ts'" > inputs.txt
	ffmpeg.exe -f concat -safe 0 -i inputs.txt -c copy $argv[3]
	rm inputs.txt input1.ts input2.ts
end
funcsave combine > /dev/null

function mpm3
	for file in (ls)
		ffmpeg.exe -i $file (string replace -r '\.mp4$' '.mp3' $file)
	end
	trash-put *.mp4
end
funcsave mpm3 > /dev/null