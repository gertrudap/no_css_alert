MissContent = MissContent or {}

if CLIENT then
    surface.CreateFont("ErrorAlert", {
        font = "Roboto Light",
        size = ScrH() / 50,
        weight = 300,
        extended = true,
        outline = true
    })
end

function MissContent.MegaCloud()
    gui.OpenURL("https://mega.nz/file/2BtiDbra#aEZ3LA6Q6Ke1Qo-UfumR4iftzIt9NHoSR_4dmcu4YGs")
end

function MissContent.MediaFire()
    gui.OpenURL("https://www.mediafire.com/file/tq86hwjie2dlioo/cstrike.rar/file")
end

function MissContent.ShowGuide()
    local menu = vgui.Create("DFrame")
    menu:SetSize(ScrW() * 0.625, ScrH() * 0.675)
    menu:Center()
    menu:SetTitle("How to mount content from Counter-Strike: Source")
    menu:ShowCloseButton(true)
    menu:SetDraggable(false)
    menu:MakePopup()
    menu:SetAlpha(0)
    menu:AlphaTo(255, 0.5)

    menu.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 240))
    end

    local html = vgui.Create("DHTML", menu)
    html:Dock(FILL)
    html:SetHTML([[
		<link href="https://fonts.googleapis.com/css2?family=Unbounded:wght@400&display=swap" rel="stylesheet">
		<style>
		body {
		font-family: 'Unbounded', sans-serif;
		background-color: rgba(40, 40, 40, 0.8);
		color: #f5f5f5;
		margin: 0;
		padding: 0;
		}
		.wrapper {
		max-width: 700px;
		margin: 50px auto;
		background: rgba(50, 50, 50, 0.7);
		padding: 30px;
		border-radius: 10px;
		box-shadow: 0px 0px 10px 2px rgba(255, 204, 0, 0.5);
		}
		h1, h2 {
		color: #ffcc00;
		text-shadow: 2px 2px 4px #000;
		text-align: center;
		}
		hr {
		border: none;
		height: 1px;
		background: #555;
		margin: 10px 0;
		}
		ul {
		list-style: none;
		padding: 0;
		}
		li {
		margin: 10px 0;
		font-size: 16px;
		}
		a {
		color: #60c0f0;
		text-decoration: none;
		transition: color 0.3s ease;
		}
		a:hover {
		color: #ffcc00;
		}
		.section {
		margin: 20px 0;
		}
		.btn-container {
		text-align: center;
		margin-top: 10px;
		}
		.btn {
		display: inline-block;
		width: 200px;
		margin: 10px;
		padding: 10px;
		background: #444;
		color: #fff;
		border: 2px solid #555;
		border-radius: 20px;
		font-size: 18px;
		text-align: center;
		transition: background 0.3s, color 0.3s;
		}
		.btn:hover {
		background: #60c0f0;
		border-color: #ffcc00;
		color: #000;
		}
		</style>
		<div class="wrapper">
		<div class="section">
		<h2>If you have Counter-Strike: Source</h2>
		<hr>
		<ul>
		<li>Download <b>CS:S</b> from <b>Steam</b> library</li>
		<li>Restart <b>Garry's Mod</b></li>
		<li>In the game menu click on <b>Games</b> button</li>
		<li>Check the box next to <b>Counter-Strike: Source</b></li>
		<li>Restart <b>Garry's Mod</b></li>
		<li>Join the server again</li>
		</ul>
		</div>
		<div class="section">
		<h2>If you don't have Counter-Strike: Source</h2>
		<hr>
		<p style="text-align: center;">Download content from any of this links:</p>
		<div class="btn-container">
		<button class="btn" onclick="console.log('RUNLUA:MissContent.MegaCloud()')">Mega Cloud</button>
		<button class="btn" onclick="console.log('RUNLUA:MissContent.MediaFire()')">Media Fire</button>
		</div>
		<p style="text-align: center; margin-top: 20px;">After downloading:</p>
		<ul>
		<li>Unarchive the folder <b><i>cstrike</i></b> to <b><i>garrysmod/addons/</i></b></li>
		<li>Restart <b>Garry's Mod</b></li>
		<li>Join the server again</li>
		</ul>
		</div>
		<div class="section">
		<h2>Where I can find addons folder?</h2>
		<hr>
		<ul>
		<li>Press <i>RMB</i> on <b>Garry's Mod</b> in <b>Steam</b> library</li>
		<li>Select the tab <i>'Properties'</i></li>
		<li>Go to the tab <i>'Installed Files'</i></li>
		<li>Click on button <i>'Browse...'</i></li>
		<li>Open the folder <i>'garrysmod'</i></li>
		</ul>
		</div>
		</div>
	]])

    html:SetAllowLua(true)
end

function MissContent.RenderAlert()
    draw.DrawText("CSS content is missing, type !css to get instructions.", "ErrorAlert", ScrW() / 2, 0, Color(245, 10, 245), 1)
end

function MissContent.ChatCommand(ply, text)
    if ply == LocalPlayer() then
        if string.lower(text) == "!css" then
            MissContent.ShowGuide()
        end
    end
end

function MissContent.NotifyPlayer()
    if not IsMounted("cstrike") and Material("skybox/de_cobble_hdrbk.vtf"):IsError() then
        chat.AddText(Color(245, 10, 10), "You don't have CSS content, You'll see red ERROR models and pink-black textures!")
        MissContent.ShowGuide()
        hook.Add("HUDPaint", "MissContent.RenderAlert", MissContent.RenderAlert)
        hook.Add("OnPlayerChat", "MissContent.ChatCommand", MissContent.ChatCommand)
    end

    hook.Remove("KeyPress", "MissContent.NotifyPlayer")
end

hook.Add("KeyPress", "MissContent.NotifyPlayer", MissContent.NotifyPlayer)