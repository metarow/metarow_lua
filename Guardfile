group :specs do
  guard :shell, :all_on_start => true do
    watch(%r{specs/(.*)/(.*).lua}) {|m| `busted specs/#{m[1]}/#{m[2]}.lua` }
  end
end

guard :shell do
  watch(%r{lib/(.*)/(.*).lua}) do |m|
    `for spec in specs/#{m[1]}/#{m[2]}*_spec.lua;do printf "%s" "\e[38;5;61m$spec\e[0m"&&busted $spec;done`
  end
end
