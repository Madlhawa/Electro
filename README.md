# Electro
IR-project

#Git hub setup
  1 ls -al ~/.ssh
    if there is no files like id_dsa.pub
                              id_ecdsa.pub
                              id_ed25519.pub
                              
  2 eval $(ssh-agent -s)
      Agent pid 59566
      
  3 ssh-keygen -t rsa -b 59566 -C "your_email@example.com"
      Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]
      Enter passphrase (empty for no passphrase): [Type a passphrase]
      Enter same passphrase again: [Type passphrase again]
 
  4 eval $(ssh-agent -s)
  
  5 ssh-add ~/.ssh/id_rsa
  
  6 cat ~/.ssh/id_rsa.pub
  
  copy the content and send to madhawa242@gmail.com 
