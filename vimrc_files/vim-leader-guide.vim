let g:lmap =  {}
let g:lmap.b = { 'name' : 'Buffer Menu' }
let g:lmap.c = { 'name' : 'Code Menu' }
let g:lmap.f = { 'name' : 'Format Menu' }
let g:lmap.g = { 'name' : 'Git Menu' }
let g:lmap.s = { 'name' : 'Search Menu' }
let g:lmap.t = { 'name' : 'Toggle Menu' }

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <leader> :<C-U>LeaderGuide ' '<CR>
nnoremap <leader>? :<C-U>LeaderGuide ' '<CR>
vnoremap <leader> :<C-U>LeaderGuideVisual ' '<CR>
vnoremap <leader>? :<C-U>LeaderGuideVisual ' '<CR>

let g:bangmap = {}
let g:bangmap.r = { 'name' : 'RC File' }

call leaderGuide#register_prefix_descriptions("!", "g:bangmap")
nnoremap ! :<C-U>LeaderGuide '!'<CR>
nnoremap !? :<C-U>LeaderGuide '!'<CR>
vnoremap ! :<C-U>LeaderGuideVisual '!'<CR>
vnoremap !? :<C-U>LeaderGuideVisual '!'<CR>
