OUTPUTDIR=hypepat.com
REMOTEDIR=/www

SSH_KEY=freebsd

RSYNC_EXCLUDE=.DS_Store

.PHONY: clean

publish:
	jekyll build

rsync: publish
	rsync -azP --exclude="$(RSYNC_EXCLUDE)" $(OUTPUTDIR) $(SSH_KEY):$(REMOTEDIR)

clean: 
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)