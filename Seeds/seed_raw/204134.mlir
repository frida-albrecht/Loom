module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.966200e+02> : tensor<8x3x3x1xf32>}> : () -> tensor<8x3x3x1xf32>
    %1 = "tosa.const"() <{values = dense<3.100000e+01> : tensor<8x1x1x1xf32>}> : () -> tensor<8x1x1x1xf32>
    %2 = "tosa.const"() <{values = dense<1> : tensor<7x4x2x2xi8>}> : () -> tensor<7x4x2x2xi8>
    %3 = tosa.pow %0, %1 : (tensor<8x3x3x1xf32>, tensor<8x1x1x1xf32>) -> tensor<8x3x3x1xf32>
    %4 = tosa.bitwise_not %2 : (tensor<7x4x2x2xi8>) -> tensor<7x4x2x2xi8>
    %5 = tosa.reduce_sum %4 {axis = 3 : i32} : (tensor<7x4x2x2xi8>) -> tensor<7x4x2x1xi8>
    %cast = tensor.cast %3 : tensor<8x3x3x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<7x4x2x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

