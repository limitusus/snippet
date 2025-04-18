.PHONY: run
ALL: run

run:
	for region in \
		ap-northeast-1 us-east-1 ap-southeast-1; \
	do \
		./offerings-to-table > $$region.csv; \
	done
