-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("pause", Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Home()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Passport = vRP.Passport(source)
        local Identity = vRP.Identity(Passport)
        local Gemstone = vRP.Account(Identity["License"])["Gemstone"]
        local Experiences = {}
        if Passport then
            for key, value in pairs(Works) do
                Experiences[value] = vRP.GetExperience(Passport, key)
            end
        end

        return {
            ["Information"] = {
                ["Passport"] = Passport,
                ["Name"] = Identity["Name"].." "..Identity["Lastname"],
                ["Bank"] = Identity["Bank"],
                ["Phone"] = Identity["Phone"],
                ["Diamonds"] = Gemstone,
                ["Blood"] =  Sanguine(Identity["Blood"]),
                ["Sex"] = Identity["Sex"],
            },
            ["Medic"] = Identity["Medic"],
            ["Premium"] = PremiumRenew,
            ["Experience"] = Experiences
        }
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUMRENEW
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PremiumRenew()
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    local Premium = MinimalTimers(Identity["Premium"] - os.time())
    if Passport then
        if not vRP.UserPremium(Passport) then
            if vRP.Request(source,"Loja","Adiquirir premium para você por <b>$"..PremiumRenew["Value"].."</b> diamantes?") then
                if vRP.PaymentGems(Passport,PremiumRenew["Value"]) then
                    vRP.SetPremium(source)
                    vRP.SetPermission(Passport,"Premium")
                    TriggerClientEvent("Notify",source,false,"Premium ativo","verde",10000)
                end
            end
        else
            if vRP.Request(source,"Loja","Você ainda possui <b>"..Premium.."</b> de premium ativo, deseja renovar mesmo assim?") then
                if vRP.HasPermission(Passport,"Premium") and vRP.PaymentGems(Passport,PremiumRenew["Value"]) then
                    vRP.UpgradePremium(source)
                    TriggerClientEvent("Notify",source,false,"Premium renovado","verde",10000)
                end
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAMONDSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DiamondsList()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local DiamondsList = {}
        for Item, v in pairs(ShopItens) do
            local keyList = {}

            DiamondsList[#DiamondsList + 1] = {
                ["Name"] = itemName(Item),
                ["Index"] = itemIndex(Item),
                ["Image"] = itemIndex(Item),
                ["Description"] = itemDescription(Item),
                ["Price"] = v["Price"],
                ["Discount"] = v["Discount"]
            }
        end

        return DiamondsList
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAMONDSBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DiamondsBuy(Item,Amount)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.PaymentGems(Passport,math.floor(ShopItens[Item]["Price"] * (100 - ShopItens[Item]["Discount"]) / 100) * Amount) then
            vRP.GenerateItem(Passport,Item,Amount,false)
            TriggerClientEvent("Notify",source,"Sucesso","Compra concluida.","verde",5000)
        else
            TriggerClientEvent("Notify",source,"Aviso","<b>Diamantes</b> insuficientes.","amarelo",5000)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experiences = {}
        if Passport then
            for key, value in pairs(Works) do
                Experiences[value] = vRP.GetExperience(Passport, key)
            end
        end

		return Experiences
	end
end