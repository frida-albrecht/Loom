module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-20> : tensor<6x2xi8>}> : () -> tensor<6x2xi8>
    %1 = "tosa.const"() <{values = dense<3> : tensor<6x1xi8>}> : () -> tensor<6x1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<4x7x2xi32>}> : () -> tensor<4x7x2xi32>
    %3 = "tosa.const"() <{values = dense<-99> : tensor<4x7x2xi32>}> : () -> tensor<4x7x2xi32>
    %c1 = "tosa.const"() <{values = dense<3> : tensor<6x2xi8>}> : () -> tensor<6x2xi8>
    %4 = tosa.minimum %0, %c1 : (tensor<6x2xi8>, tensor<6x2xi8>) -> tensor<6x2xi8>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %7 = tosa.negate %4, %5, %6 : (tensor<6x2xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<6x2xi8>
    %8 = tosa.add %7, %7 : (tensor<6x2xi8>, tensor<6x2xi8>) -> tensor<6x2xi8>
    %9 = tosa.intdiv %2, %3 : (tensor<4x7x2xi32>, tensor<4x7x2xi32>) -> tensor<4x7x2xi32>
    %cast = tensor.cast %8 : tensor<6x2xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<4x7x2xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}