require 'xcodeproj'

#This program uses 'xcodeproj' to edit .pbxproj (in .xcodeproj) file for iOS app developing without Xcode.

if ARGV.length == 0 then 
	puts 'add source to first group, target. : THISPROGRAM {proj-path} {source}'
	puts 'EXAMPLE                            : THISPROGRAM hoge.xcodeproj foo.swift'
end

if ARGV.length == 2 then
	project = Xcodeproj::Project.open(ARGV[0])

	group = project.groups[0]

	source = Xcodeproj::Project::FileReferencesFactory.new_reference(group, ARGV[1], :group)

	target = project.targets[0]
	target.add_file_references([source])

	project.save
end

