module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7> : tensor<7x2xi8>}> : () -> tensor<7x2xi8>
    %1 = "tosa.const"() <{values = dense<-6.031000e+01> : tensor<7x7x7x10xf32>}> : () -> tensor<7x7x7x10xf32>
    %2 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %0, %2 : (tensor<7x2xi8>, !tosa.shape<2>) -> tensor<21x6xi8>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<21x6xi8>, tensor<21x6xi8>) -> tensor<21x6xi8>
    %5 = tosa.exp %1 : (tensor<7x7x7x10xf32>) -> tensor<7x7x7x10xf32>
    %cast = tensor.cast %4 : tensor<21x6xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<7x7x7x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

