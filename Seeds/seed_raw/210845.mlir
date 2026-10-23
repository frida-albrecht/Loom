module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<9x4x10x10xi8>}> : () -> tensor<9x4x10x10xi8>
    %1 = "tosa.const"() <{values = dense<-1.094600e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %2 = tosa.bitwise_not %0 : (tensor<9x4x10x10xi8>) -> tensor<9x4x10x10xi8>
    %3 = tosa.rsqrt %1 : (tensor<8xf32>) -> tensor<8xf32>
    %4 = tosa.bitwise_xor %2, %2 : (tensor<9x4x10x10xi8>, tensor<9x4x10x10xi8>) -> tensor<9x4x10x10xi8>
    %5 = tosa.abs %3 : (tensor<8xf32>) -> tensor<8xf32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %8 = tosa.negate %4, %6, %7 : (tensor<9x4x10x10xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<9x4x10x10xi8>
    %9 = tosa.bitwise_xor %8, %8 : (tensor<9x4x10x10xi8>, tensor<9x4x10x10xi8>) -> tensor<9x4x10x10xi8>
    %10 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %11 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %12 = tosa.negate %5, %10, %11 : (tensor<8xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<8xf32>
    %cast = tensor.cast %9 : tensor<9x4x10x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %12 : tensor<8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

