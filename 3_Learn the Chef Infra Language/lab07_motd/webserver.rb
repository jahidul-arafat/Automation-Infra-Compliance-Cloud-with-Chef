apt_update 'Update the apt cache daily' do    # resource 01
  frequency 86_400
  action :periodic
end

package 'apache2'                             # resource 02

service 'apache2' do
  supports status: true
  action [:enable, :restart]                  # resource 03, 04
end

file '/var/www/html/index.html' do            # resource 05
  content '<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>'
end