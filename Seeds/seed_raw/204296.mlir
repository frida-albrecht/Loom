module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<20> : tensor<2x3xi8>}> : () -> tensor<2x3xi8>
    %1 = "tosa.const"() <{values = dense<1.186400e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %2 = "tosa.const"() <{values = dense<1.005400e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %3 = "tosa.const"() <{values = dense<113> : tensor<7xi32>}> : () -> tensor<7xi32>
    %4 = "tosa.const"() <{values = dense<-21> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.const_shape  {values = dense<[1, 3, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.reshape %0, %5 : (tensor<2x3xi8>, !tosa.shape<4>) -> tensor<1x3x1x2xi8>
    %7 = tosa.pow %1, %2 : (tensor<9xf32>, tensor<9xf32>) -> tensor<9xf32>
    %8 = tosa.intdiv %3, %4 : (tensor<7xi32>, tensor<1xi32>) -> tensor<7xi32>
    %9 = tosa.reduce_max %6 {axis = 3 : i32} : (tensor<1x3x1x2xi8>) -> tensor<1x3x1x1xi8>
    %10 = tosa.bitwise_xor %8, %8 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %11 = tosa.concat %10, %10 {axis = 0 : i32} : (tensor<7xi32>, tensor<7xi32>) -> tensor<14xi32>
    %12 = tosa.reduce_product %11 {axis = 0 : i32} : (tensor<14xi32>) -> tensor<1xi32>
    %13 = tosa.intdiv %11, %11 : (tensor<14xi32>, tensor<14xi32>) -> tensor<14xi32>
    %cast = tensor.cast %7 : tensor<9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<1x3x1x1xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %12 : tensor<1xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %13 : tensor<14xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}

