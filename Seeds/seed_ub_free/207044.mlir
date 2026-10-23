module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<4x5x1x5xi8>}> : () -> tensor<4x5x1x5xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<4x5x1x5xi8>}> : () -> tensor<4x5x1x5xi8>
    %2 = "tosa.const"() <{values = dense<-1.592500e+02> : tensor<8x2x8xf32>}> : () -> tensor<8x2x8xf32>
    %3 = "tosa.const"() <{values = dense<-1.220600e+02> : tensor<1x1x8xf32>}> : () -> tensor<1x1x8xf32>
    %4 = tosa.minimum %0, %1 : (tensor<4x5x1x5xi8>, tensor<4x5x1x5xi8>) -> tensor<4x5x1x5xi8>
    %c1 = "tosa.const"() <{values = dense<0.0> : tensor<8x2x8xf32>}> : () -> tensor<8x2x8xf32>
    %t0 = tosa.maximum %2, %c1 : (tensor<8x2x8xf32>, tensor<8x2x8xf32>) -> tensor<8x2x8xf32>
    %c2 = "tosa.const"() <{values = dense<1.0> : tensor<1x1x8xf32>}> : () -> tensor<1x1x8xf32>
    %t1 = tosa.maximum %3, %c2 : (tensor<1x1x8xf32>, tensor<1x1x8xf32>) -> tensor<1x1x8xf32>
    %5 = tosa.pow %t0, %t1 : (tensor<8x2x8xf32>, tensor<1x1x8xf32>) -> tensor<8x2x8xf32>
    %cast = tensor.cast %4 : tensor<4x5x1x5xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<8x2x8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}