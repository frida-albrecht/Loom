module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<7xi8>}> : () -> tensor<7xi8>
    %1 = "tosa.const"() <{values = dense<13> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<4.054000e+01> : tensor<1x9x10xf32>}> : () -> tensor<1x9x10xf32>
    %3 = tosa.minimum %0, %1 : (tensor<7xi8>, tensor<1xi8>) -> tensor<7xi8>
    %4 = tosa.ceil %2 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %5 = tosa.exp %4 : (tensor<1x9x10xf32>) -> tensor<1x9x10xf32>
    %cast = tensor.cast %3 : tensor<7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<1x9x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

