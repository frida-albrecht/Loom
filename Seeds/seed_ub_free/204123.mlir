module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.513000e+01> : tensor<9x3xf32>}> : () -> tensor<9x3xf32>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<1x10xi8>}> : () -> tensor<1x10xi8>
    %2 = tosa.tanh %0 : (tensor<9x3xf32>) -> tensor<9x3xf32>
    %3 = tosa.clz %1 : (tensor<1x10xi8>) -> tensor<1x10xi8>
    %4 = tosa.exp %2 : (tensor<9x3xf32>) -> tensor<9x3xf32>
    %5 = tosa.clz %3 : (tensor<1x10xi8>) -> tensor<1x10xi8>
    %6 = tosa.reciprocal %4 : (tensor<9x3xf32>) -> tensor<9x3xf32>
    %7 = tosa.clamp %3 {max_val = -34 : i8, min_val = -42 : i8} : (tensor<1x10xi8>) -> tensor<1x10xi8>
    %cast = tensor.cast %5 : tensor<1x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<9x3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %7 : tensor<1x10xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}

