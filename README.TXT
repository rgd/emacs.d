
Emacs initialization on multiple PCs


USWIC-L-0074462  - main laptop
   ~/.emacs.d/init.el

C64DEVROB	 - main dev VM
   ~/.emacs.d/init.el

ComposerDevD20	 - dev Linux box
   ~/.emacs.d/init.el


<dropbox>/.emacs.d/
   emacs.conf.el     - used by all
   init.el           - not used except as example - need to copy to each machine's ~/.emacs.d



OR

Maybe want to make the local init.el ONLY smart enough to find dropbox/.emacs.d/emacs.conf.el

so only time they would need changed is when dropbox location changes.

All machine-specific setup done in emacs.conf.el - then that's synced via dropbox and doesn't need copied around

