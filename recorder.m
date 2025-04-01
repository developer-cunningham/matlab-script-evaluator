function recorder(script_name)
    % Capture output from script execution
    output_log = 'console_output.txt';
    diary(output_log);  % Start logging console output
    diary on;

    try
        run(script_name);  % Run the provided script
    catch ME
        fprintf('Error running script: %s\n', ME.message);
    end

    diary off;  % Stop logging console output

    % Capture all open figure windows
    fig_handles = findobj('Type', 'figure');  % Get all figure handles
    for i = 1:length(fig_handles)
        figure(fig_handles(i));  % Bring figure to foreground
        screenshot_filename = sprintf('screenshot_%d.png', i);
        print(fig_handles(i), screenshot_filename, '-dpng', '-r300');  % Save as PNG
        fprintf('Saved figure %d as %s\n', i, screenshot_filename);
    end

    fprintf('Console output saved in %s\n', output_log);
end
