-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT DISTINCT p.apellido1, p.apellido2, p.nombre FROM persona p JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno ORDER BY p.apellido1, p.apellido2, p.nombre;
-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno WHERE p.telefono IS NULL;
-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona p JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno WHERE YEAR(p.fecha_nacimiento) = '1999';
-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona pe JOIN profesor pr ON pe.id = pr.id_profesor WHERE pe.telefono IS NULL AND pe.nif LIKE '%K';
-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
-- Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT pe.apellido1, pe.apellido2, pe.nombre, d.nombre FROM persona pe JOIN profesor pr ON pe.id = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id ORDER BY pe.apellido1, pe.apellido2, pe.nombre;
-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asig.nombre, ce.anyo_inicio, ce.anyo_fin FROM asignatura asig JOIN alumno_se_matricula_asignatura asma ON asig.id = asma.id_asignatura JOIN curso_escolar ce ON asma.id_curso_escolar = ce.id JOIN persona per ON asma.id_alumno = per.id WHERE per.nif = '26902806M';
-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN grado g ON a.id_grado = g.id WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.nombre FROM persona p JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno JOIN asignatura a ON asma.id_asignatura = a.id JOIN curso_escolar ce ON asma.id_curso_escolar = ce.id WHERE ce.anyo_inicio = '2018' AND ce.anyo_fin = '2019';

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre, pe.apellido1, pe.apellido2, pe.nombre FROM persona pe JOIN profesor pr ON pe.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id ORDER BY d.nombre, pe.apellido1, pe.apellido2, pe.nombre;
-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT * FROM persona pe JOIN profesor pr ON pe.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE d.nombre IS NULL;
-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT * FROM persona pe JOIN profesor pr ON pe.id = pr.id_profesor RIGHT JOIN departamento d ON pr.id_departamento = d.id WHERE pe.nombre is NULL;
-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT * FROM persona pe JOIN profesor pr ON pe.id = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.nombre IS NULL;
-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT * FROM persona pe JOIN profesor pr ON pe.id = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id RIGHT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE pe.nombre IS NULL;
-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT * FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN alumno_se_matricula_asignatura asma ON a.id = asma.id_asignatura RIGHT JOIN curso_escolar ce ON asma.id_curso_escolar = ce.id WHERE a.nombre IS NULL;

-- Consultes resum:

-- Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(DISTINCT(asma.id_alumno)) FROM persona p JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno;
-- Calcula quants alumnes van néixer en 1999.
SELECT COUNT(DISTINCT(asma.id_alumno)) FROM persona p JOIN alumno_se_matricula_asignatura asma ON p.id = asma.id_alumno WHERE YEAR(p.fecha_nacimiento) = '2000';
-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT d.nombre, p.nombre FROM persona p JOIN profesor prof ON p.id = prof.id_profesor JOIN departamento d ON prof.id_departamento = d.id ORDER BY p.nombre;
-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre, p.nombre FROM persona p JOIN profesor prof ON p.id = prof.id_profesor RIGHT JOIN departamento d ON prof.id_departamento = d.id ORDER BY p.nombre;
-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT * FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado ORDER BY a.nombre;
-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT DISTINCT g.nombre FROM grado g JOIN asignatura a ON g.id = a.id_grado WHERE (SELECT COUNT(g.id) FROM grado g JOIN asignatura a ON g.id = a.id_grado) > 40;
-- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

-- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

-- Retorna totes les dades de l'alumne/a més jove.

-- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
