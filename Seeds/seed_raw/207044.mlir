module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<4x5x1x5xi8>}> : () -> tensor<4x5x1x5xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<4x5x1x5xi8>}> : () -> tensor<4x5x1x5xi8>
    %2 = "tosa.const"() <{values = dense<-1.592500e+02> : tensor<8x2x8xf32>}> : () -> tensor<8x2x8xf32>
    %3 = "tosa.const"() <{values = dense<-1.220600e+02> : tensor<1x1x8xf32>}> : () -> tensor<1x1x8xf32>
    %4 = tosa.minimum %0, %1 : (tensor<4x5x1x5xi8>, tensor<4x5x1x5xi8>) -> tensor<4x5x1x5xi8>
    %5 = tosa.pow %2, %3 : (tensor<8x2x8xf32>, tensor<1x1x8xf32>) -> tensor<8x2x8xf32>
    %cast = tensor.cast %4 : tensor<4x5x1x5xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<8x2x8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

