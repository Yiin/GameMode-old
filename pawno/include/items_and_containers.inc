// core
native CreateItem(const name[], level = 1);
native DeleteItem(uiid);

// item info
// getters
native GetItemType     (uiid);
native GetItemName     (uiid, str[]);
native GetItemLevel    (uiid);
native GetItemEffect   (uiid, effect);
native CountItemEffects(uiid);
native GetItemInfo     (uiid, const info[]);
// setters
native SetItemType     (uiid, type);
native SetItemLevel    (uiid, level);
native SetItemEffect   (uiid, effect, value);
native SetItemInfo     (uiid, info[], value);

// container
enum eContainerType {
	Player,
	Shop,
	Vehicle,
	Other
};

native SaveInventory          (playerid);
native LoadInventory          (playerid);

native DeleteContainer        (containerType, containerId);
native SaveContainer          (containerType, containerId);
native LoadContainer          (containerType, containerId);
native AddItemToContainer     (containerType, containerId, uiid);
native RemoveItemFromContainer(containerType, containerId, uiid);
native CountItemsInContainer  (containerType, containerId);

native IsItemInContainer      (containerType, containerId, const str[]);
native FindItemInContainer	  (containerType, containerId, const str[], nth = 0);
native GetItemInContainer	  (containerType, containerId, index);
