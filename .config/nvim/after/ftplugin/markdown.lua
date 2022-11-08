vim.keymap.set("n", "<leader>mk",
               ":!pandoc -t ms --toc -C -N --csl=ieee --bibliography=../Papers/bib.bib -i % -o %:r.tmp.pdf<cr>",
               {noremap = true})
