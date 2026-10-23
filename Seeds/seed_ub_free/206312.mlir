module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-16> : tensor<4x2xi8>}> : () -> tensor<4x2xi8>
    %1 = "tosa.const"() <{values = dense<-1.179000e+02> : tensor<4x8x5x3xf32>}> : () -> tensor<4x8x5x3xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<4x2xi8>) -> tensor<1x2xi8>
    %3 = tosa.identity %2 : (tensor<1x2xi8>) -> tensor<1x2xi8>
    %4 = tosa.reciprocal %1 : (tensor<4x8x5x3xf32>) -> tensor<4x8x5x3xf32>
    %5 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.tile %3, %5 : (tensor<1x2xi8>, !tosa.shape<2>) -> tensor<3x6xi8>
    %cast = tensor.cast %4 : tensor<4x8x5x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<3x6xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

