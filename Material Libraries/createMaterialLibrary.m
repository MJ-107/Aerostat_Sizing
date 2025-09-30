function library = createMaterialLibrary()
    % Envelope materials
    envelope(1) = envelopeMaterial('Steel', 45.5, 'https://example.com/steel');
    envelope(2) = envelopeMaterial('Aluminum', 15.3, 'https://example.com/aluminum');
    envelope(3) = envelopeMaterial('Titanium', 20.1, 'https://example.com/titanium');

    % Sealant materials
    tether(1) = tetherMaterial('Silicone Sealant', 10.0, 'https://example.com/silicone');
    tether(2) = tetherMaterial('Polyurethane Sealant', 8.5, 'https://example.com/polyurethane');

    % Combine into a library struct
    library.Envelope = envelope;
    library.Tether = tether;
end

