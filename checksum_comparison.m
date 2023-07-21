function checksum_comparison()
    % XOR Checksum
    function xorChecksum = calculateXORChecksum(data)
        xorChecksum = bitxor(data(1), data(2));
        for i = 3:length(data)
            xorChecksum = bitxor(xorChecksum, data(i));
        end
    end

    % One's Complement Checksum
    function onesComplementChecksum = calculateOnesComplementChecksum(data)
        onesComplementChecksum = sum(data);
        while onesComplementChecksum > 65535
            onesComplementChecksum = mod(onesComplementChecksum, 65536) + floor(onesComplementChecksum / 65536);
        end
        onesComplementChecksum = bitcmp(uint16(onesComplementChecksum));
    end

    % Two's Complement Checksum
    function twosComplementChecksum = calculateTwosComplementChecksum(data)
        twosComplementChecksum = sum(data);
        while twosComplementChecksum > 65535
            twosComplementChecksum = mod(twosComplementChecksum, 65536) + floor(twosComplementChecksum / 65536);
        end
        twosComplementChecksum = bitcmp(uint16(twosComplementChecksum)) + 1;
    end

    % Fletcher Checksum
    function fletcherChecksum = calculateFletcherChecksum(data)
        sum1 = 0;
        sum2 = 0;
        for i = 1:length(data)
            sum1 = mod(sum1 + data(i), 65535);
            sum2 = mod(sum2 + sum1, 65535);
        end
        fletcherChecksum = bitshift(sum2, 8) + sum1;
    end

    % Adler Checksum
    function adlerChecksum = calculateAdlerChecksum(data)
        prime = 65521;
        sum1 = 1;
        sum2 = 0;
        for i = 1:length(data)
            sum1 = mod(sum1 + data(i), prime);
            sum2 = mod(sum2 + sum1, prime);
        end
        adlerChecksum = bitshift(sum2, 16) + sum1;
    end

    % Test data
    data = [10 20 30 40 50];

    % Calculate and display checksums
    xorChecksum = calculateXORChecksum(data);
    onesComplementChecksum = calculateOnesComplementChecksum(data);
    twosComplementChecksum = calculateTwosComplementChecksum(data);
    fletcherChecksum = calculateFletcherChecksum(data);
    adlerChecksum = calculateAdlerChecksum(data);

    % Display checksums
    disp('Checksums:');
    disp(['XOR Checksum: ' num2str(xorChecksum)]);
    disp(['One''s Complement Checksum: ' num2str(onesComplementChecksum)]);
    disp(['Two''s Complement Checksum: ' num2str(twosComplementChecksum)]);
    disp(['Fletcher Checksum: ' num2str(fletcherChecksum)]);
    disp(['Adler Checksum: ' num2str(adlerChecksum)]);
end
