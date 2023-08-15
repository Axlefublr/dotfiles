#!/usr/bin/env fish

function cut
	ffmpeg -i $argv[1] -ss $argv[3] -to $argv[4] -c:a copy $argv[2]
end
funcsave cut > /dev/null

function cutfrom
	ffmpeg -i $argv[1] -ss $argv[3] -c:a copy $argv[2]
end
funcsave cutfrom > /dev/null

function cutto
	ffmpeg -i $argv[1] -ss 00:00 -to $argv[3] -c:a copy $argv[2]
end
funcsave cutto > /dev/null

function cutout
	ffmpeg -i $argv[1] -to $argv[3] -c:a copy input1.mp4
	ffmpeg -i $argv[1] -ss $argv[4] -c:a copy input2.mp4
	combine input1.mp4 input2.mp4 $argv[2]
	rm input1.mp4 input2.mp4
end
funcsave cutout > /dev/null

function compress
	ffmpeg -i $argv[1] -c:v libx264 -crf 28 -preset veryslow -c:a aac -b:a 64k -movflags +faststart $argv[2]
end
funcsave compress > /dev/null

function combine
	ffmpeg -i $argv[1] -c copy -bsf:v h264_mp4toannexb -f mpegts input1.ts
	ffmpeg -i $argv[2] -c copy -bsf:v h264_mp4toannexb -f mpegts input2.ts
	echo "file 'input1.ts'
	file 'input2.ts'" > inputs.txt
	ffmpeg -f concat -safe 0 -i inputs.txt -c copy $argv[3]
	rm inputs.txt input1.ts input2.ts
end
funcsave combine > /dev/null

function mp43
	for file in (ls)
		ffmpeg -i $file (uclanr -j - 3).mp3
		trash-put $file
	end
end
funcsave mp43 > /dev/null

function renameall
	for file in (ls)
		mv $file (uclanr -j - 3)(path extension $file)
	end
end
funcsave renameall > /dev/null
