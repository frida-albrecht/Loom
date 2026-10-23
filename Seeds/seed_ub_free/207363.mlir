module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-8.212000e+01> : tensor<7x4x8x10xf32>}> : () -> tensor<7x4x8x10xf32>
    %2 = "tosa.const"() <{values = dense<-9.110000e+01> : tensor<1x1x8x1xf32>}> : () -> tensor<1x1x8x1xf32>
    %3 = tosa.bitwise_not %0 : (tensor<i8>) -> tensor<i8>
    %4 = tosa.bitwise_not %3 : (tensor<i8>) -> tensor<i8>
    %5 = tosa.maximum %1, %2 : (tensor<7x4x8x10xf32>, tensor<1x1x8x1xf32>) -> tensor<7x4x8x10xf32>
    %6 = tosa.exp %5 : (tensor<7x4x8x10xf32>) -> tensor<7x4x8x10xf32>
    %cast = tensor.cast %4 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<7x4x8x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

