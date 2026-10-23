module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.425800e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<-9> : tensor<i8>}> : () -> tensor<i8>
    %3 = tosa.tanh %0 : (tensor<3xf32>) -> tensor<3xf32>
    %4 = tosa.reciprocal %3 : (tensor<3xf32>) -> tensor<3xf32>
    %5 = tosa.logical_left_shift %1, %2 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %6 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<3xf32>) -> tensor<1xf32>
    %7 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %8 = tosa.tile %6, %7 : (tensor<1xf32>, !tosa.shape<1>) -> tensor<1xf32>
    %9 = tosa.exp %8 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %5 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

