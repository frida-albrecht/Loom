module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<3xi8>}> : () -> tensor<3xi8>
    %1 = "tosa.const"() <{values = dense<4.778000e+01> : tensor<9xf32>}> : () -> tensor<9xf32>
    %2 = "tosa.const"() <{values = dense<-1.893800e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<3xi8>) -> tensor<1xi8>
    %4 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.reshape %3, %4 : (tensor<1xi8>, !tosa.shape<4>) -> tensor<1x1x1x1xi8>
    %6 = tosa.pow %1, %2 : (tensor<9xf32>, tensor<1xf32>) -> tensor<9xf32>
    %7 = "tosa.const"() <{values = dense<[0, 1, 2, 3]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %8 = tosa.transpose %5 {perms = array<i32: 0, 1, 2, 3>} : (tensor<1x1x1x1xi8>) -> tensor<1x1x1x1xi8>
    %cast = tensor.cast %6 : tensor<9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<1x1x1x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

