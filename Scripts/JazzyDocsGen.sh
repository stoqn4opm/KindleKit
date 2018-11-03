#!/bin/bash
# A simple script that generates html documentation with the help of 'jazzy' (https://github.com/realm/jazzy) and opens it in browser.

###########################################

# Best way to use it:
# 1. Inside your project folder, create folder called 'Scripts'
# 2. Put this file 'JazzyDocsGen.sh' inside it.
# 3. In XCode, go to your project settings where targets are listed, and tap the '+' button to add new target.
# 4. Select the template Cross-platform > Other > Aggregate.
# 5. Name the target as you wish, appropriate name would be 'Generate Docs`.
# 6. Select the new target, and open its build phases pane.
# 7. Tap the "+" to create new run script phase.
# 8. Expand the newly appeared run script section and type in the following code:

# ```
#	# pass as first argument the folder name in which you want your documentation to be placed.    
#	# pass as second argument the visibility level you want to be seen. (private | internal | public | open)
#	# pass as third argument where is your README file in your repo from the locality of the directory that holds this project file.
#	sh ./Scripts/JazzyDocsGen.sh ./Documentation private ../README.md
# ```

# 9. Now in XCode you can select this target and build it, and your browser should open the generated docs.

###########################################
# SCRIPT START:

# Expecting first parameter to be the directory in which you want the docs to be generated.
documentationDirectory=$1

# The level of visibility in your documentation. Can be (private | internal | public | open)
visibilityLevel=$2

# The path to the readme in your project.
readmePath=$3


# Checks whether the 'jazzy' tool is installed.
jazzyIsInstalled=$(gem list '^jazzy$' -i)

rm -rf $documentationDirectory

if [ $jazzyIsInstalled == true ]; then
	jazzy --min-acl $visibilityLevel --output $documentationDirectory --readme $readmePath &&
	cd $documentationDirectory &&
	open index.html
else
	mkdir $documentationDirectory
	cd $documentationDirectory &&
	echo "<h1 style=\"color: #5e9ca0;\">&#x1F989 Error while trying to build documenation.<hr></h1>
	<h2>It&nbsp;seems like you don't have 'jazzy' installed.</h2>
	<h2>How to install it &#x1F9D0 :</h2>
	<blockquote>
	<p><code>sudo gem install jazzy</code></p>
	</blockquote>
	<p>The Xcode command-line developer tools must be installed to successfully build the gems that <code>jazzy</code> depends on: try <code>xcode-select --install</code> if you see build errors.</p>
	<p><em>jazzy is a command-line utility that generates documentation for Swift or Objective-C</em></p>
	<p><em>You can read more about it <a href=\"https://github.com/realm/jazzy\">in this README.md on GitHub</a></em></p>
	<p>&nbsp;</p>" >> index.html &&
	open index.html
fi
