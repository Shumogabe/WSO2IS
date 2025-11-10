<%!
    public static String getClaimValue(String tenantDomain, String userName, String claimUri) {
        int tenantId = IdentityTenantUtil.getTenantId(tenantDomain);
        try {
            return IdentityTenantUtil.getRealmService().getTenantUserRealm(tenantId).getUserStoreManager().getUserClaimValue(userName, claimUri, null);
        } catch (Exception e) {
            return null;
        }
    }
    public String getUsernameFromMappingClaim(String claimValue, String claimURI, String tenantDomain, String profileName) {
        try {
            int tenantId = IdentityTenantUtil.getTenantId(tenantDomain);
            UserStoreManager userStoreManager = (UserStoreManager) IdentityTenantUtil.getRealmService().getTenantUserRealm(tenantId).getUserStoreManager();
            String[] username = userStoreManager.getUserList(claimURI, claimValue, profileName);
            return username[0];
        } catch (Exception e) {
            return null;
        }
    }

    public String getValue(String...args) {
        for (String arg : args) {
            if (arg != null && !arg.isEmpty()) {
                return arg;
            }
        }
        return "";
    }

%>
