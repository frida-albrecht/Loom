module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<7x6x2xi8>}> : () -> tensor<7x6x2xi8>
    %1 = "tosa.const"() <{values = dense<1.134300e+02> : tensor<1x3xf32>}> : () -> tensor<1x3xf32>
    %2 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<7x6x2xi8>) -> tensor<7x1x2xi8>
    %3 = tosa.rsqrt %1 : (tensor<1x3xf32>) -> tensor<1x3xf32>
    %4 = tosa.sub %3, %3 : (tensor<1x3xf32>, tensor<1x3xf32>) -> tensor<1x3xf32>
    %5 = tosa.sigmoid %4 : (tensor<1x3xf32>) -> tensor<1x3xf32>
    %6 = tosa.log %4 : (tensor<1x3xf32>) -> tensor<1x3xf32>
    %cast = tensor.cast %2 : tensor<7x1x2xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<1x3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %6 : tensor<1x3xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

