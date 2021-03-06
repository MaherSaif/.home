# Makefile to install .home on the target system

# destination path
DEST_PATH = $(HOME)/.home

# files to delete from $HOME
DOT_FILES = $(HOME)/.zshrc $(HOME)/.gemrc $(HOME)/.screenrc $(HOME)/sshblack

# oh-my-zsh Repository to be used
OH_MY_REPO = https://github.com/sorin-ionescu/oh-my-zsh.git

# local .zshrc (gets inserted into .zshrc for local specialities)
LOCAL_SETTINGS_FILE = $(HOME)/.local.zshrc

ZSH_PATH = `which zsh`

install: $(HOME)/.oh-my-zsh clean $(DOT_FILES) $(LOCAL_SETTINGS_FILE) help
	
clean:
	rm -f $(DOT_FILES)
help:
	@echo "done"
	@echo 
	@echo " => now run 'chsh -s' to change your used shell to activate settings"
	@echo 
	@echo "run 'make sshblack' to run sshblack.pl for the first time"

sshblack:
	# run it the first time to register cron job
	sudo $(HOME)/sshblack/sshblack.pl

# target to clone oh-my-zsh repository
$(HOME)/.oh-my-zsh:
	git clone $(OH_MY_REPO) $(HOME)/.oh-my-zsh
	cd $(HOME)/.oh-my-zsh
	git submodule update --init --recursive
	
	
# sym links
$(HOME)/.zshrc:
	ln -s $(DEST_PATH)/.zshrc $(HOME)/.zshrc

$(HOME)/.gemrc:
	ln -s $(DEST_PATH)/.gemrc $(HOME)/.gemrc
$(HOME)/.screenrc:
	ln -s $(DEST_PATH)/.screenrc $(HOME)/.screenrc
$(HOME)/sshblack:
	ln -s $(DEST_PATH)/bin/sshblack $(HOME)/sshblack
	
	

# local settings file
$(LOCAL_SETTINGS_FILE):
	touch $(LOCAL_SETTINGS_FILE)

