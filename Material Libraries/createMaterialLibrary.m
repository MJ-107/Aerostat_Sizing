function library = createMaterialLibrary()

    % Lifting Gas
    % Input gas(x) = tetherMaterial('A', B, 'C')
    % A = title of gas (string)
    % B = density kg per m^3
    % C = link to specification page (string)
    gas(1) = liftingGas('Helium', 0.1785, 'https://example.com/mat1');
    gas(2) = liftingGas('Hydrogen', 0.0827, 'https://example.com/mat2');

    % Envelope materials
    % Input envelope(x) = envelopeMaterial('A', B, 'C')
    % A = title of material (string)
    % B = weight in kg per m^2
    % C = link to specification page (string)
    envelope(1) = envelopeMaterial('Envelope Mat 1', 1.6, 'https://example.com/mat1');
    envelope(2) = envelopeMaterial('Envelope Mat 2', 3.1, 'https://example.com/mat2');
    envelope(3) = envelopeMaterial('Envelope Mat 3', 4.0, 'https://example.com/mat3');

    % Tether materials
    % Input tether(x) = tetherMaterial('A', B, 'C')
    % A = title of material (string)
    % B = weight in kg per m^2
    % C = link to specification page (string)
    tether(1) = tetherMaterial('Tether Mat 1', 10.0, 'https://example.com/mat1');
    tether(2) = tetherMaterial('Tether Mat 2', 8.5, 'https://example.com/mat2');

    % Combine into a library struct
    library.LiftingGas = gas;
    library.Envelope = envelope;
    library.Tether = tether;
end

