module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-116> : tensor<10xi16>}> : () -> tensor<10xi16>
    %1 = "tosa.const"() <{values = dense<49> : tensor<10xi16>}> : () -> tensor<10xi16>
    %2 = "tosa.const"() <{values = dense<-4.635000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<10xi16>, tensor<10xi16>) -> tensor<10xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.negate %3, %4, %5 : (tensor<10xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<10xi16>
    %7 = tosa.sub %6, %6 : (tensor<10xi16>, tensor<10xi16>) -> tensor<10xi16>
    %8 = tosa.reduce_max %7 {axis = 0 : i32} : (tensor<10xi16>) -> tensor<1xi16>
    %9 = tosa.add %8, %8 : (tensor<1xi16>, tensor<1xi16>) -> tensor<1xi16>
    %10 = tosa.reciprocal %2 : (tensor<2xf32>) -> tensor<2xf32>
    %11 = tosa.log %10 : (tensor<2xf32>) -> tensor<2xf32>
    %cast = tensor.cast %9 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %11 : tensor<2xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

