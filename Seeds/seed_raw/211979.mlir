module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.837000e+01> : tensor<6x9xf32>}> : () -> tensor<6x9xf32>
    %1 = "tosa.const"() <{values = dense<9.035000e+01> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = "tosa.const"() <{values = dense<16> : tensor<8x10x4xi8>}> : () -> tensor<8x10x4xi8>
    %3 = "tosa.const"() <{values = dense<-2> : tensor<8x1x1xi8>}> : () -> tensor<8x1x1xi8>
    %4 = tosa.maximum %0, %1 : (tensor<6x9xf32>, tensor<1x1xf32>) -> tensor<6x9xf32>
    %5 = tosa.reduce_product %4 {axis = 0 : i32} : (tensor<6x9xf32>) -> tensor<1x9xf32>
    %6 = tosa.minimum %5, %5 : (tensor<1x9xf32>, tensor<1x9xf32>) -> tensor<1x9xf32>
    %7 = tosa.logical_left_shift %2, %3 : (tensor<8x10x4xi8>, tensor<8x1x1xi8>) -> tensor<8x10x4xi8>
    %8 = tosa.log %6 : (tensor<1x9xf32>) -> tensor<1x9xf32>
    %cast = tensor.cast %7 : tensor<8x10x4xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<1x9xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

