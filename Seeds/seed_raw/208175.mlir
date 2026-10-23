module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-10> : tensor<5x9xi8>}> : () -> tensor<5x9xi8>
    %1 = "tosa.const"() <{values = dense<-8.177000e+01> : tensor<5x10x1xf32>}> : () -> tensor<5x10x1xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<5x9xi8>) -> tensor<1x9xi8>
    %3 = tosa.const_shape  {values = dense<[3, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.tile %2, %3 : (tensor<1x9xi8>, !tosa.shape<2>) -> tensor<3x9xi8>
    %5 = tosa.logical_left_shift %4, %4 : (tensor<3x9xi8>, tensor<3x9xi8>) -> tensor<3x9xi8>
    %6 = tosa.ceil %1 : (tensor<5x10x1xf32>) -> tensor<5x10x1xf32>
    %cast = tensor.cast %5 : tensor<3x9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<5x10x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

