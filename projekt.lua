-- Wlasne funkcje

function stopnieNaRadiany(stopnie)
    local wynik = (stopnie * PI)/180
    return wynik
end
--  /////////////////////////////////////////////
function rysujWirnik(r, offset, ileRamion)

stopnie = 360 / (3*ileRamion)

mi_selectnode(0, r[2])
mi_copyrotate(0, 0, stopnie, 360/stopnie)

for i = 0+offset, 360/stopnie -1 + offset, 3 do
	mi_selectnode(r[2]*cos(stopnieNaRadiany(stopnie*i)), r[2]*sin(stopnieNaRadiany(stopnie*i)))
	mi_deleteselected();

end


mi_selectnode(0, r[1])
mi_copyrotate(0, 0, stopnie/2, 720/stopnie)

for i = 3+offset, 720/stopnie + offset , 6 do
	mi_selectnode(r[1]*cos(stopnieNaRadiany(stopnie/2*i)), r[1]*sin(stopnieNaRadiany(stopnie/2*i)))
	mi_deleteselected();
end

--		Rysujemy proste by ukoczyc wirnik
local j = 2 + offset
for i = 1+offset, 360/stopnie - 1 + offset, 3 do
	mi_addsegment(r[2]*cos(stopnieNaRadiany(stopnie*i)),r[2]*sin(stopnieNaRadiany(stopnie*i)), r[1]*cos(stopnieNaRadiany(stopnie/2*j)), r[1]*sin(stopnieNaRadiany(stopnie/2*j)))
mi_addsegment(r[2]*cos(stopnieNaRadiany(stopnie*(i+1))),r[2]*sin(stopnieNaRadiany(stopnie*(i+1))), r[1]*cos(stopnieNaRadiany(stopnie/2*(j+2))), r[1]*sin(stopnieNaRadiany(stopnie/2*(j+2))))
	j = j + 6
end
end


--/////////////////////////////////////////////////////////// Stojak
function rysujStojak(r, offset, ileRamion)
ilePunktow = ileRamion * 3
stopnie = 360 / ilePunktow
print(ilePunktow, stopnie)


mi_selectnode(0, r[2])
mi_copyrotate(0, 0, stopnie, ilePunktow)

for i = 0+offset, ilePunktow + offset , 3 do
	mi_selectnode(r[2]*cos(stopnieNaRadiany(stopnie*i)), r[2]*sin(stopnieNaRadiany(stopnie*i)))
	mi_deleteselected();
end

mi_selectnode(0, r[1])
mi_copyrotate(0, 0, stopnie/2, 2*ilePunktow)



--		Rysujemy proste

local j = 1 + offset
for i = 1+offset, ilePunktow + offset, 2 do

	j = j + 2
end
end



--------------------       main:    -------------------------

-- Rozne kolka

local r = {4, 12, 14, 15, 17, 30}
mi_addnode(0,0) 
for i = 1, 6 do
	mi_addnode(0,r[i])
	mi_addnode(0,-r[i]) 
	mi_addarc(0, r[i], 0, -r[i], 180, 1)
	mi_addarc( 0, -r[i], 0, r[i], 180, 1)
end


rysujWirnik({r[2], r[3]}, 0, 4)
rysujStojak({r[4], r[5]}, 0, 6)

function GetMaterial(material)
    return mi_getmaterial(material)
end

GetMaterial('Copper')
GetMaterial('M-19')
GetMaterial('Pure Iron') -- nie jestem pewnien czy to ten materiał 

function AddMaterial_default(material, x, y)
    local mux = 1
    local muy = 1
    local Hc = 0
    local J = 0
    local Cduct = 0
    local Lamd = 0
    local Phi_max = 0
    local lam = 1
    local lam_type = 0
    local phi_x = 0
    local phi_y = 0
    local nstr = 1
    local dwire = 1

    mi_addmaterial(material, mux, muy, Hc, J, Cduct, Lamd, Phi_max, lam, lam_type, phi_x, phi_y, nstr, dwire)

    mi_setblockprop(material,0,0, "<None>", 0,0 , 0)
    mi_addblocklabel(x,y)
    mi_selectlabel(x,y)
    mi_setblockprop(material,0, 0, "<None>", 0, 0 , 1)
    mi_clearselected()
end

function AddMaterial_complex(material, x, y, mux, muy, Hc, J, Cduct, Lamd, Phi_max, lam, lam_type, phi_x, phi_y, nstr, dwire)
    mi_addmaterial(material, mux, muy, Hc, J, Cduct, Lamd, Phi_max, lam, lam_type, phi_x, phi_y, nstr, dwire)
    
    mi_setblockprop(material, 0, 0, "<None>", 0, 0, 0)
    mi_addblocklabel(x, y)
    mi_selectlabel(x, y)
    mi_setblockprop(material, 0, 0, "<None>", 0, 0, 1)
    mi_clearselected()
end
-- mu x Relative permeability in the x- or r-direction.
-- – mu y Relative permeability in the y- or z-direction.
-- – H c Permanent magnet coercivity in Amps/Meter.
-- – J Applied source current density in Amps/mm2
-- .
-- – Cduct Electrical conductivity of the material in MS/m.
-- – Lam d Lamination thickness in millimeters.
-- – Phi hmax Hysteresis lag angle in degrees, used for nonlinear BH curves.
-- – Lam fill Fraction of the volume occupied per lamination that is actually filled with iron (Note 
-- that this parameter defaults to 1 in the femm preprocessor dialog box because, by default, 
-- iron completely fills the volume)
-- – Lamtype Set to
-- ∗ 0 – Not laminated or laminated in plane
-- ∗ 1 – laminated x or r
-- ∗ 2 – laminated y or z
-- ∗ 3 – magnet wire
-- ∗ 4 – plain stranded wire
-- ∗ 5 – Litz wire
-- ∗ 6 – square wire
-- – Phi hx Hysteresis lag in degrees in the x-direction for linear problems.
-- – Phi hy Hysteresis lag in degrees in the y-direction for linear problems.
-- – nstr Number of strands in the wire build. Should be 1 for Magnet or Square wire.
-- – dwire Diameter of each of the wire’s constituent strand in millimeters.


AddMaterial('Copper', -0.5, 1.5)
AddMaterial('M-19', -1, 7)
AddMaterial('M-19', -7, 23)
