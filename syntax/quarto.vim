runtime syntax/pandoc.vim
PandocHighlight r

syn region pandocRChunk
      \ start=/\(```\s*{\s*r.*\n\)\@<=\_^/
      \ end=/\_$\n\(\(\s\{4,}\)\=\(`\{3,}`*\|\~\{3,}\~*\)\_$\n\_$\)\@=/
      \ contained
      \ containedin=pandocDelimitedCodeblock
      \ contains=@R

syn region pandocInlineR matchgroup=Operator start=/`r\s/ end=/`/ contains=@R concealends

PandocHighlight python
" quarto recognizes embedded Python differently than regular pandoc
syn region pandocPythonChunk
            \ start=/\(```\s*{\s*python.*\n\)\@<=\_^/
            \ end=/\_$\n\(\(\s\{4,}\)\=\(`\{3,}`*\|\~\{3,}\~*\)\_$\n\_$\)\@=/
            \ contained
            \ containedin=pandocDelimitedCodeblock
            \ contains=@python

syn region pandocInlinePython matchgroup=Operator start=/`python\s/ end=/`/ contains=@Python concealends

" Highlight code recognized by pandoc but not defined in pandoc.vim
syn match pandocDivBegin '^:::\+ {.\{-}}' contains=pandocHeaderAttr
syn match pandocDivEnd '^:::\+$'

" Highlight knitr chunk options
syn region knitrChunkOptions
      \ matchgroup=knitrChunkOptionsBegin
      \ start='^#| '
      \ end='$'
      \ contained
      \ containedin=pandocRChunk,pandocPythonChunk
      \ contains=@Yaml

" Multiline yaml strings should not highlight knitr chunk option markers
syn match knitrChunkOptionsBegin
      \ "^#| "
      \ contained
      \ containedin=yamlFlowString

highlight default link pandocDivBegin Delimiter
highlight default link pandocDivEnd Delimiter
highlight default link knitrChunkOptionsBegin Comment
