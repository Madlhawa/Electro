# Electro
<h2>IR-project</h2>
<ul>
  <li>Project has two main folders. (data and web-scraper)</li>
  <li><b>data</b> contain the all the data that is scraped by team contain only csv or json files</li>
  <li>web-scraper contain folder with name of each team member, members must code within their assigned directory</li>
  

<hr>
<h3><b>Git hub setup</b></h3>
  <h4>1 ls -al ~/.ssh</h4>
    if there is no files like id_dsa.pub
                              id_ecdsa.pub
                              id_ed25519.pub
                              <br><br>
  <h4>2 eval $(ssh-agent -s)</h4>
      Agent pid 59566
       <br>
  <h4>3 ssh-keygen -t rsa -b 4096 -C "your_email@example.com"</h4>
      Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]
      Enter passphrase (empty for no passphrase): [Type a passphrase]
      Enter same passphrase again: [Type passphrase again]
  <br>
  <h4>4 eval $(ssh-agent -s)</h4>
  <h4>5 ssh-add ~/.ssh/id_rsa</h4>
  <h4>6 cat ~/.ssh/id_rsa.pub</h4>
  <h4>copy the content and send to madhawa242@gmail.com </h4>
<hr>
<h3><b>For first commit</b></h3>
<h4>go to the location where you want to download files</h4>
<h4>git clone git@github.com:Madlhawa/Electro.git</h4>
<h4>git --config --edit</h4>
<h4>Edit the name with your git username and email with email that you used for git</h4>
