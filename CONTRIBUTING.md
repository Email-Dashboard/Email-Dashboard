# Contributing to Email-Dashboard

Hello 👋

Looking to contribute something to Email-Dashboard? <b>You're at the right place!</b> We are grateful for all volunteers like you for contributions. We are excited to welcome you aboard! But first, please take a moment to read this document in order to make the contribution process effective for everyone. Following these guidelines will help to developers and you, for time managing. So, if you ready let's make Email-Dashboard better together! 

Happy contributing 🎉

# Rules of the discussions

Before start to contributing to Email-Dashboard or any open source project please don't forget to follow these rules:

1. Using welcoming and inclusive language in your comments or discussions,
2. Always being respectful to differing viewpoints and experiences,
3. Gracefully accepting constructive criticism,
4. Focusing on what is best for the community and project,
5. Showing empathy towards other community members,
6. Keep the language to English, 
6. And loving Superman more than Batman!

# Ways to contribute

Here we are! There are many ways you can contribute to Email-Dashboard. For example:

🛠 You can test Email-Dashboard and <b>report bugs</b> you find. Also you can also fix these bugs!  
:guardsman: You can write <b>unit tests</b> for Email-Dashboard.<br>
🌐 You can <b>translate</b> Email-Dashboard's UI, our README and CONTRIBUTING contents into other languages or help to keep those translations up to date.<br>
📝 You can write <b>guide articles</b> about usage of Email-Dashboard and help to keep it up to date.<br>
💻 You can implement a <b>new feature</b> to Email-Dashboard!<br>
:mailbox: You can create new <b>email templates</b> for community.<br>
🛠 You can help people on the <b>issue</b> tracker.<br>

# Getting Email-Dashboard

1. Fork a copy of our repo
2. Open up Git in an environment of your choice
3. Run the following


Clone your fork of the repo into the current directory:
```
$ git clone https://github.com/YOUR-GITHUB-PROFILE-NAME/Email-Dashboard.git
```
Navigate to the newly cloned directory:
```
$ cd Email-Dashboard
```

Before start to contibuting don't forget, one PR per feature/fix unless you follow [standard-version](https://github.com/conventional-changelog/standard-version) commit guidelines. If you are new, this guide can help you about [how to contribute a project](https://opensource.guide/how-to-contribute/).

# Issues and labels

The [issue tracker](https://github.com/Email-Dashboard/Email-Dashboard/issues) is the preferred channel for bug reports, features requests and submitting pull requests. Our issue tracker utilizes several [labels](https://github.com/Email-Dashboard/Email-Dashboard/labels) to help organize and identify issues. Here's what they represent:
  
Labels  | Description
------------- | -------------
`bug`  | Something isn't working!
`duplicate` | This issue or pull request already exists!
`enhancement` | New feature or request
`good first issue` | Good for newcomers!
`help wanted` | Extra attention is needed!
`wontfix` | This will not be worked on!
`invalid` | This doesn't seem right!
`question` | Further information is requested!

So, when you want to start contributing on this issue labels please don't forget rules of the discussions. Also when working on any issue on Github, it's a good practice to make branches that are specific to the issue you're currently working on. For instance, if you're working on an issue with a name like "NAME OF ISSUE #1234", from the master branch run the following code: `git checkout -b Issue#1234`. In doing so, you'll be making a branch that specifically identifies the issue at hand, and moves you right into it with the `checkout` flag. This keeps your main (master) repository clean and your personal workflow cruft out of sight when making a pull request. 

After you've forked and cloned our repo, you can find issues to work on by heading over to our [issues list](https://github.com/Email-Dashboard/Email-Dashboard/issues). We advise looking at the issues with the labels [help wanted](https://github.com/Email-Dashboard/Email-Dashboard/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) or [good first issue](https://github.com/Email-Dashboard/Email-Dashboard/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22), as they will help you get familiar with the Email-Dashboard code.

# Bug reports & fix

A bug is a curse for code! That's why good bug reports are extremely helpful for every project, so thanks! You can follow this guidelines for bug reports:

:small_orange_diamond: Validate and lint your code.<br>

:small_orange_diamond: Use the GitHub issue search.<br>

:small_orange_diamond: Check if the issue has been fixed.<br>

And please try to be as detailed as possible in your report.

# Feature requests

Good pull requests—patches, improvements, new features—are a fantastic help! That's why feature, improvements requests are welcome. But before opening a feature request, please take a moment to find out whether your idea fits with the scope and aims of the project. It's up to you to make a strong case to convince the project's developers of the merits of this feature. So, you can provide as much detail and context as possible. 

But how to make changes if you're a newbie? Here is it!

First, start out on master. You can check this by using `git status`. Before making your changes use `git pull` so that you can be sure you are working on the latest version of master.

```
$ git pull
```

Then use `git branch` to create a new branch for doing your work. Make sure to name it something that describes your changes.

```
$ git branch branchName
```

Even though you've now created a new branch, you aren't "on" that branch yet. Switch from Master to your new branch by using `git checkout`

```
$ git checkout branchName
```

Then make your changes directly by editing the files. Once you're finished making changes, use `git commit -m` to confirm them and describe what you changed.

```
$ git commit fileName -m "description of my changes"
```

When prompted for the message, write a description of what you did. After that push the changes to Github using `git push --set-upstream`. That's it. Easy peasy right?

