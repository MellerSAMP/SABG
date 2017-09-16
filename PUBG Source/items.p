enum items {
	ITEM_APPLE
}

GetItemWeight(item) {
	switch(item) {
		case ITEM_APPLE: return 1;
	}
	return 0;
}