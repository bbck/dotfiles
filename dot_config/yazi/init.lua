-- Statusline in the style of lualine: full mode name, and a colored
-- filetype icon in front of the filename
function Status:mode()
	local style = self:style()
	return ui.Line {
		ui.Span(" " .. tostring(self._tab.mode):upper() .. " "):style(style.main),
		ui.Span(th.status.sep_left.close):fg(style.main:bg()):bg(style.alt:bg()),
	}
end

function Status:name()
	local h = self._current.hovered
	if not h then
		return ""
	end

	local icon = th.icon:match(h)
	return ui.Line {
		ui.Span(" "),
		icon and ui.Span(icon.text .. " "):style(icon.style) or "",
		ui.Span(ui.printable(h.name)),
	}
end

-- Keep icon colors on the hovered file, like Neovim's pickers
function Entity:icon()
	local icon = th.icon:match(self._file, { hovered = self._file.is_hovered })
	return icon and ui.Line(icon.text .. " "):style(icon.style) or ""
end
