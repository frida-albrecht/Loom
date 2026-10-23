module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.012900e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = "tosa.const"() <{values = dense<-9> : tensor<1x6x6x1xi8>}> : () -> tensor<1x6x6x1xi8>
    %2 = "tosa.const"() <{values = dense<6> : tensor<1x1x6x1xi8>}> : () -> tensor<1x1x6x1xi8>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<7xf32>}> : () -> tensor<7xf32>
    %a1 = tosa.maximum %0, %c0 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %3 = tosa.rsqrt %a1 : (tensor<7xf32>) -> tensor<7xf32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<7xf32>, !tosa.shape<1>) -> tensor<7xf32>
    %6 = tosa.maximum %5, %5 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %c1 = "tosa.const"() <{values = dense<3.402823466e+38> : tensor<7xf32>}> : () -> tensor<7xf32>
    %b1 = tosa.minimum %6, %c1 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %c2 = "tosa.const"() <{values = dense<3.402823466e+38> : tensor<7xf32>}> : () -> tensor<7xf32>
    %b2 = tosa.minimum %3, %c2 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %7 = tosa.pow %b1, %b2 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %8 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.tile %7, %8 : (tensor<7xf32>, !tosa.shape<1>) -> tensor<7xf32>
    %10 = tosa.logical_right_shift %1, %2 : (tensor<1x6x6x1xi8>, tensor<1x1x6x1xi8>) -> tensor<1x6x6x1xi8>
    %11 = tosa.tanh %9 : (tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %10 : tensor<1x6x6x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %11 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}