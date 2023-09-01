# see https://github.com/nodejs/corepack/pull/244
function yarn -w 'corepack yarn'
	corepack yarn $argv
end
