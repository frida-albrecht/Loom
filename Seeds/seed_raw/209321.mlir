module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<5xi8>}> : () -> tensor<5xi8>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<5xi8>}> : () -> tensor<5xi8>
    %2 = "tosa.const"() <{values = dense<2.369000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.logical_left_shift %0, %1 : (tensor<5xi8>, tensor<5xi8>) -> tensor<5xi8>
    %4 = tosa.const_shape  {values = dense<[5, 1, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.reshape %3, %4 : (tensor<5xi8>, !tosa.shape<4>) -> tensor<5x1x1x1xi8>
    %6 = tosa.exp %2 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.rsqrt %6 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %5 : tensor<5x1x1x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

